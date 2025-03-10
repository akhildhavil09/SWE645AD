pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = akhild9  // e.g., Docker Hub username or ECR URL
        DOCKER_IMAGE_NAME = "${DOCKER_REGISTRY}/swe645-webapp"
        KUBERNETES_NAMESPACE = "swe645"
        AWS_REGION = "us-east-2"  // Change to match your AWS region if using EKS
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with a tag that includes the Jenkins build number
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} ."
                    
                    // Also tag it as 'latest'
                    sh "docker tag ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} ${DOCKER_IMAGE_NAME}:latest"
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker registry (you would need to configure credentials in Jenkins)
                    withCredentials([string(credentialsId: 'docker-registry-credentials', variable: 'DOCKER_PASSWORD')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login ${DOCKER_REGISTRY} -u ${DOCKER_REGISTRY} --password-stdin"
                    }
                    
                    // Push both tags
                    sh "docker push ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
                    sh "docker push ${DOCKER_IMAGE_NAME}:latest"
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Configure kubectl with your K8s cluster (for EKS)
                    // For EKS, you would use:
                    // sh "aws eks update-kubeconfig --region ${AWS_REGION} --name your-cluster-name"
                    
                    // Alternative: For a self-managed cluster, you would use kubectl directly with credentials
                    
                    // Apply the Kubernetes configuration files with dynamic Docker image name
                    sh "envsubst < k8s-deployment.yaml | kubectl apply -f - -n ${KUBERNETES_NAMESPACE}"
                    sh "kubectl apply -f k8s-service.yaml -n ${KUBERNETES_NAMESPACE}"
                    
                    // Verify deployment
                    sh "kubectl rollout status deployment/swe645-webapp -n ${KUBERNETES_NAMESPACE}"
                }
            }
        }
    }
    
    post {
        always {
            // Clean up local Docker images to save space
            sh "docker rmi ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
            sh "docker rmi ${DOCKER_IMAGE_NAME}:latest"
        }
        
        success {
            echo 'Deployment successful!'
        }
        
        failure {
            echo 'Deployment failed!'
        }
    }
}