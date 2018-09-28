node {
  try {
    stage('Checkout') {
      checkout scm
    }
    stage('Environment') {
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
     // sh 'docker -v'
      sh 'printenv'
    }
    stage('Build Docker test'){
     sh 'sudo docker build -t hello-test -f Dockerfile.test --no-cache .'
    }
    stage('Docker test'){
      sh 'sudo docker run --rm hello-test'
    }
    stage('Clean Docker test'){
      sh 'sudo docker rmi hello-test'
    }
    stage('Deploy'){
      if(env.BRANCH_NAME == 'master'){
        sh 'sudo docker build -t gittest --no-cache .'
        sh 'sudo docker tag gittest localhost:5000/gittest'
        sh 'sudo docker push localhost:5000/gittest'
		sh 'sudo docker rmi -f gittest localhost:5000/gittest'
      }
    }
	stage('Production'){
      if(env.BRANCH_NAME == 'master'){
	    //sh 'docker rm $(docker stop $(docker ps -a -q --filter "ancestor=localhost:5000/gittest" --format="{{.ID}}"))'
	    //sh 'docker ps -a -q --filter "ancestor=localhost:5000/gittest" --format="{{.ID}}" | xargs -r docker stop | xargs -r docker rm'
	      sh 'sudo docker run -d -p 8090:8080 --name hellojava localhost:5000/gittest'
      }
    }
  }
  catch (err) {
    throw err
  }
}
