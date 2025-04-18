#!/bin/bash
service ssh start
service nginx start
service tor start

# Keep container running
tail -f /dev/null