#!/bin/bash

# JQ pattern for extracting Jira subtask IDs

echo "Jira Subtask IDs: $(jq -r '[.fields.subtasks[].key]' jira-issue.json)"