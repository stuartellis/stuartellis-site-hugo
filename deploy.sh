#!/bin/sh

hugo -v 
s3deploy -source=public/ -region=eu-west-2 -bucket=www.stuartellis.name