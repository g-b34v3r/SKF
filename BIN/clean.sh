#!/bin/bash
#
#
echo "cleaning up..."
rm -rf FILE/*
touch FILE/templates.list FILE/dorx.list FILE/hosts.list FILE/cdorx.list
rm .tmp/*
touch .tmp/1.tmp .tmp/2.tmp .tmp/3.tmp .tmp/dlist.tmp .tmp/cfg.list
echo "done cleaning..."
