pipeline {
    agent {
        dockerfile true
    }
    stages {
        stage('Exec') {
            steps {
                echo 'Hello world..'
                sh 'echo HTTP_PORT = $HTTP_PORT'
            }
        }
    }
}