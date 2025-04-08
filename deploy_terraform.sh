#!/bin/bash

# Maximum number of attempts
MAX_ATTEMPTS=1000
current_attempt=0
current_ad=0

while [ $current_attempt -lt $MAX_ATTEMPTS ]; do
    clear    
    echo "Attempt $((current_attempt+1)) with availability_domain = $current_ad"
    
    # Export the variable for Terraform to use
    # export TF_VAR_availability_domain=$current_ad
    
    # Run terraform apply with auto-approve
    terraform apply -auto-approve -var="availability_domain=$current_ad"
    
    # Check if terraform was successful
    if [ $? -eq 0 ]; then
        echo "Terraform apply succeeded with availability_domain = $current_ad"
        break
    fi
    
    # Increment attempt counter
    current_attempt=$((current_attempt+1))
    
    # Cycle availability domain between 0, 1, and 2
    current_ad=$(( (current_ad + 1) % 3 ))
    echo "Terraform failed. Trying again with availability_domain = $current_ad"
    # Optional: add a delay before retrying
    sleep 30
done

if [ $current_attempt -eq $MAX_ATTEMPTS ]; then
    echo "Maximum attempts reached. Terraform apply failed."
    exit 1
fi

echo "Deployment completed successfully"