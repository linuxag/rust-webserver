pipeline
{
    agent
    {
        label 'control'
    }
    parameters { 
    string(name: 'project_owner_team_email', defaultValue: project_owner_team_email, description: 'project_owner_team_email') 
    string(name: 'app_version', defaultValue: 'v1', description: 'app_version') 
    }
    stages
    {
        stage('send-notification')
        {
            
            steps{
                script 
                {
                    emailext subject: '${JOB_NAME} - ${BUILD_NUMBER} ', body: 'Job url : ${BUILD_URL}',  to: 'jsnrahul@gmail.com'
                }
            }
        
        }
        stage('static-analysis-k8deploy')
        {
            steps{
            sh '''
            #static analyisi of Deployment
            docker run -t -v $(pwd):/output bridgecrew/checkov -f /output/rust-cart-app1-deployment.yml -o json |  jq '.' > k8deploy_result | exit 0            
            cat k8deploy_result  | grep -B 2 FAILED
            '''
            }
        }
        stage('deploy')
        {
            
            steps{
                sh '''
                sed -i 's/unique_tag/$app_version/g' rust-cart-app1-deployment.yml
                #echo "kubectl deploy"
                kubectl apply -f rust-cart-app1-deployment.yml
                '''
            }
        
        }
        stage('smoke-test')
        {
            
            steps{
                sh '''
                sleep 15
                curl 10.8.0.2:30010
                '''
            }
        
        }
        
    }
}
