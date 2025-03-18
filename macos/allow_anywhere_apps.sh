#!/bin/sh

echo "executing: sudo spctl --master-disable"
echo "you may be prompted for your password"

sudo spctl --master-disable &&
    echo "select 'anywhere' from System Preferences > Security & Privacy > General" ||
    echo "something went wrong"
