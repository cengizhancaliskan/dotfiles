#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Arc.app"
dockutil --no-restart --add "/Applications/Notion Calendar.app"
dockutil --no-restart --add "/System/Applications/Notes.app"
dockutil --no-restart --add "/System/Applications/Reminders.app"
dockutil --no-restart --add "/Applications/GoLand.app/"
dockutil --no-restart --add "/System/Applications/PyCharm.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/WhatsApp.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"

killall Dock