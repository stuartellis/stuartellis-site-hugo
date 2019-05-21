#!/bin/sh

hugo -v 
s3deploy -source=public/ -public-access -region=eu-west-2 -bucket=www.stuartellis.name -distribution-id=E3FWVVWISZCBK9