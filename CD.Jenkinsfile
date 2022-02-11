pipeline
{
    agent
    {
        label 'worker1'
    }
    parameters { 
        string(name: 'app_version', defaultValue: 'v1', description: 'app_version') 
    }
    stages
    {
        stage('send-notification')
        {
            
            steps{
                /*script 
                {
                    emailext subject: '${JOB_NAME} - ${BUILD_NUMBER} ', body: 'Job url : ${BUILD_URL}',  to: 'ashutoshgupta0077@gmail.com'
                }*/
                sh '''
                echo "mail sent"
                '''
            }
        
        }
        stage('static-analysis-k8deploy')
        {
            steps{
            sh '''
            #static analyisi of Deployment
            #docker run -t -v $(pwd):/output bridgecrew/checkov -f /output/rust-cart-app1-deployment.yml -o json |  jq '.' > k8deploy_result | exit 0            
            #cat k8deploy_result  | grep -B 2 FAILED
            '''
            }
        }
        stage('deploy')
        {
            
            steps{
                sh '''
                sed -i "s/unique_tag/$app_version/g" rust-cart-app1-deployment.yml
                cat rust-cart-app1-deployment.yml
                #echo "kubectl deploy"
                kubectl delete -f rust-cart-app1-deployment.yml | exit 0
                kubectl apply -f rust-cart-app1-deployment.yml
                '''
            }
        
        }
        stage('smoke-test')
        {
            
            steps{
                sh '''
                sleep 15
                echo "rust app deployement success"
                '''
            }
        
        }
        
    }
}
