node {
        def app
        stage('Clone repository') {
                git 'https://github.com/yangsubinn/Test-iOS.git'
        }
        stage('Build Image') {
                app = docker.build("yangsubinn/test-jenkins")
        }
        stage('Test Image') {
                app.inside {
                        sh 'make test'
                }
        }
        stage('Push image') {
                docker.withRegistry('https://registry.hub.docker.com', '231ac0f4-40ba-49f6-b419-34e2cdac6b42') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                }
        }
}
