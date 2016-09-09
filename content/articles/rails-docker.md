+++
Title = "Deploying a Ruby on Rails Application with Docker"
Slug = "rails-docker"
Date = "2016-09-09T20:20:00+01:00"
Description = "Deploying a Ruby on Rails Application with Docker"
Categories = ["administration"]
Tags = ["administration", "rails", "docker"]
Type = "article"
Draft = true

+++


This article describes a process for preparing a Ruby on Rails 4 application for deployment in Docker containers. Docker and application containerization are new and still evolving areas of technology, so the specific details will probably change as new versions of the tools are released. The process here reflects current best practices at the time of writing.

# Overview #

The [12-Factor App](http://12factor.net/) Website explains a general set of principles for server applications, including those in containers. There are also a few other principles that are specific to containers:

* Each container should enclose one specific service or application
* Each image should have the absolute minimum of contents that are needed to run that one piece of software  
* Application containers should never store information

These principles mean that you should separate all of the data away from the application container: the configuration, the application database and logging. You should run the database and other backing services in separate containers, or on other systems.

The aim is to enable you to make full use of containers. Each container should be disposable: you should be able to freely create as many copies of a container as you need on any Docker host or cluster of hosts, and be able to destroy containers without any fear of losing data.

It has been argued that using multiple containers makes it more difficult for those who are new to container technology, and makes the development process more cumbersome, but *Docker Compose* removes these issues. This utility enables you to define sets of containers that can be started and stopped together, and automatically have network access to each other. All of the containers that are managed by *Docker Compose* must be on the same host, and so it is not suitable for production use, but it is valuable for both development and testing.

To configure applications that are inside a container, the simplest approach is to modify them to read settings from environment variables as they start up. Docker can apply environment variables to containers as they boot up, which enables each container to have a unique configuration. You will usually want to apply multiple settings to each container, so use the option to read environment variables for a container from a file.

# Installing Docker on Your Workstation #

Use the most recent version of Docker that you can. Docker, Inc. currently release new versions of Docker every eight weeks with fixes and new features, and so packages will quickly become outdated.

If you are using Mac OS X, install the [Docker Toolbox](https://www.docker.com/docker-toolbox) package on to your workstation. This includes the main *Docker Engine*, the *Docker Machine* setup tool, and the *Docker Compose* container management utility. Docker, Inc. also provide packages for Ubuntu, but for other Linux distributions you should look for packages in the distribution repositories.

To manage the Amazon container service, install the *ECS CLI* tool. On Mac OS X, use Homebrew:

    brew install amazon-ecs-cli

# Preparing The Rails Application for Docker #

To make a Rails application work effectively in a Docker container, you will need to ensure that it meets these criteria:

* The database configuration should be in the form of a URL that is injected in by environment variable
* The secret key and other sensitive and environment-specific settings also must be environment variables
* The application should log to stdout (standard output), rather than directly to files
* The Web server for the application should be [Puma](https://puma.io), as the default WEBrick server has poor performance
* All shared state, such as sessions, must be removed or extracted to external services

Before you begin, first ensure that the application runs without any errors. It should be possible to drop, create and populate the application database, run the application with the development Web server, and all of the tests should pass. Avoid trying to fix problems with the application and convert it to run in Docker at the same time.

Once the application works without problems, create a branch in your version control system for the Docker changes. You will need to add and modify multiple files, and it may require a few attempts before you can successfully build a Docker image for your application.

## Amend The .gitignore File ##

Add these lines to the *.gitignore* file in the project:

    # Docker environment variable files
    .env*

If you do not use Git, amend the configuration of your version control system to exclude files whose names start with *.env*.

## Switch the Application Web Server To Puma ##

To switch the application from WEBrick to [Puma](https://puma.io), add the RubyGem for the Puma Web server to the Gemfile:

    gem "puma"

Run *bundle install* to install the gem to your development environment.

## Add Example Environment Files To The Project ##

Create two text files in the root of the project, with the names *.example.env.web* and *.example.env.db*. These will hold the environment variables for the Web application and database containers.

Copy these files and exclude them from version control.

If your application needs additional services, such a caching or queuing service, create *.env* files for the containers that will provide that service.

Each time that you set an environment variable for the application, add it to the *example.env.web* file. The format of the file has one variable per line, like this:

    RAILS_ENV=production
    DATABASE_URL=mysql2://youruser:yourpassword@yourserver/app_database
    LOG_LEVEL=ERROR
    RAILS_SERVE_STATIC_FILES=true
    SECRET_KEY_BASE=your-secret-key

This enables developers and administrators to easily see the variables that they will need to set in order to run copies of the application.

## Use an Environment Variable for the Database Configuration ##

Current versions of Ruby on Rails allow you to specify all of the details for accessing the application database in a single environment variable, called *DATABASE_URL*. The Rails documentation recommends that you use this variable by specifying it in the *config/database.yml* file with the *url* setting, like this:

    production:
      url: <%= ENV['DATABASE_URL'] %>

Change the database configuration for each environment that uses Docker to use a *url*, as shown above. Refer to [the section on configuring a database](http://guides.rubyonrails.org/configuring.html#configuring-a-database) in the Rails documentation for the format of the database URL.

Copy the database url into the *.env.web* file as the variable *DATABASE_URL*:

    DATABASE_URL=your-secret-key

## Use an Environment Variable for the Secret Key ##

Rails applications use a secret key for cookie-based security. This is a long string of letters and numbers that is unique to the application, and looks like this:

    2fba74af8b9830f4ac7ff0872c3c2069e82a41aecaeb8cc9788d92f5e44863d68268bcc887eb59fa6b8d1ee577daa5966b98fe130d6806a854e43ac927aaebf4

First, use this command to generate a new key:

    rake secret

Copy the generated key into the *.env.web* file as the variable *SECRET_KEY_BASE*:

    SECRET_KEY_BASE=your-secret-key

Edit the file *config/secrets.yml* to ad these lines:

    staging:
      secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>

## Amend the Logging To Send Messages To STDOUT ##

Amend the configuration file for each environment that uses Docker. For example,
the file  *config/environments/production.rb* is for the production environment.

The production configuration is created with a fixed log level and the other
logging settings commented out, so that they rely on the default values:

    # Use the lowest log level to ensure availability of diagnostic information
    # when problems arise.
    config.log_level = :debug

    # Prepend all log lines with the following tags.
    # config.log_tags = [ :subdomain, :uuid ]

    # Use a different logger for distributed setups.
    # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

To send log messages to STDOUT and enable the log level to be set from an
environment variable, use these values:

    config.logger = Logger.new(STDOUT)
    config.log_level = ENV.fetch("LOG_LEVEL", "ERROR")

## Decide How To Serve Static Assets ##

For production environments, there are several ways to serve the static assets
for the application. For example, you could delegate this to the reverse proxy
(as Phusion Passenger does automatically), or rely on a Content Delivery Network
(CDN), or have the Rails application containers do this work.

To have the Rails application containers serve static assets in production, add
the variable *RAILS_SERVE_STATIC_FILES* to the *.env.web* file:

    RAILS_SERVE_STATIC_FILES=true

If you use a separate system to serve static assets, then you need to amend the
file *config/environments/production.rb*. Change the *asset_host* setting to use
an environment variable. This setting is normally commented out:

    # config.action_controller.asset_host = 'http://assets.example.com'

Replace the line with this:

    config.action_controller.asset_host = ENV['RAILS_ASSET_HOST']

Then add the URL of the static assets server to the *.env.web* file as the
variable *RAILS_ASSET_HOST*:

    RAILS_ASSET_HOST=https://assets.example.com

# Add Environment Variables for Custom Configuration Settings #

If you need to specify API keys or other settings for the application, use
environment variables. Current versions of Rails provide a *config/secrets.yml*
file for extra settings.

# Caches and Shared State #

By default, Rails avoids shared state on the server by using client-side session management with cookies.

# Adding The Docker Configuration Files To The Project #

The full Docker configuration uses several files:

* *Dockerfile* - The build configuration for Docker images
* *.dockerignore* - A list of files to exclude from images
* *docker-compose.yml* - The configuration for the Docker Compose utility
* *.env.web* - A list of environment variables to provide to Docker application containers
* *.env.db* - A list of environment variables to provide to Docker database containers

Copy your *.example.env.web* file as *.env.web*.

## The Dockerfile ##

Note that we use a *CMD*, but not an *ENTRYPOINT*. *ENTRYPOINT* imposes which
executable is used, although this can still be overridden by using the
*--entrypoint* option on the command-line. *CMD* just provides a default
executable, and can be overridden just by explicitly specifying an executable
for the container (e.g. *docker -it <DOCKER-IMAGE> /bin/bash*). We will use
application containers to run setup, testing and administrative commands, and
so *ENTRYPOINT* is not appropriate.

# Common Commands #

## Build ##

You may use *Docker Compose* to build your containers:

    docker-compose build

Currently, docker-compose always tags images as *<project>_<service>*, e.g. *myapp_web*.

To fully control the image building process, use *docker build*:

    docker build -t <tag> .

## Run ##

To start the containers, use *docker-compose up*. You can then use *run* to
carry out administrative commands, such as *rake*:

    docker-compose up
    docker-compose run web rake db:migrate
    docker-compose run web rake db:seed

## Cleanup ##

To remove obsolete images and container references from Docker, run these commands:

    docker rm $(docker ps -aq)
    docker rmi $(docker images --filter dangling=true)
