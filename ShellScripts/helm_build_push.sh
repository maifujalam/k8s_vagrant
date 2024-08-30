#!/bin/bash
CHART_PATH=$1
CHART_NAME=$(basename $CHART_PATH)
HELM_REPO_NAME="public-helm-repository"  # Replace with your Helm repo name
TMP_DIR="/tmp" # temp directory where to keep latest package helm chart.

# Check if Helm chart name is passed as a parameter
if [ -z "$1" ]; then
  echo "No Argument Provided.Please provide chart folder name to package as parameter."
  exit 1
else
  echo "Packaging the $CHART_NAME from path $CHART_PATH"
  helm package $CHART_PATH --destination $TMP_DIR
fi

# Check if packaging was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to package the Helm chart."
  exit 2
fi

# Find the latest Helm chart build in /tmp
LATEST_HELM_CHART=$(ls -t ${TMP_DIR}/${CHART_NAME}-*.tgz | head -n 1)
echo "Latest helm chart build: $LATEST_HELM_CHART"

# Push the chart to Repository
echo "Pushing the Helm chart: $LATEST_HELM_CHART to the repository $HELM_REPO_NAME"
helm s3 push --force $LATEST_HELM_CHART $HELM_REPO_NAME

# Check if push was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to push the Helm chart to the repository."
  exit 3
fi

echo "Helm chart Successfully pushed to the repository."