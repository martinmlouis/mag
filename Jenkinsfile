/**
 * This pipeline will build and deploy a Docker image with Kaniko
 * https://github.com/GoogleContainerTools/kaniko
 * without needing a Docker host
 *
 * You need to create a jenkins-docker-cfg secret with your docker config
 * as described in
 * https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#create-a-secret-in-the-cluster-that-holds-your-authorization-token
 */

podTemplate(yaml: '''
              kind: Pod
              spec:
                containers:
                - name: kaniko
                  image: gcr.io/kaniko-project/executor:v1.6.0-debug
                  imagePullPolicy: Always
                  command:
                  - sleep
                  args:
                  - 99d
                - name: kaniko
                  image: gcr.io/kaniko-project/executor:v1.6.0-debug
                  imagePullPolicy: Always
                  command: ['cat']
                  tty: true
                  volumeMounts:
                  - name: jenkins-docker-cfg
                    mountPath: /kaniko/.docker
                volumes:
                - name: jenkins-docker-cfg
                  emptyDir:
                  sizeLimit: 1G  
'''
  ) {

  node{
    stage('Build with Kaniko') {
      git 'https://github.com/martinmlouis/mag.git'
      container('kaniko') {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
        sh """
          packer_version=\$(echo ${params.PACKER_VERSION} |cut -dv -f2)
          echo "{\\"auths\\":{\\"https://index.docker.io/v1/\\":{\\"username\\":\\"${DOCKERHUB_USERNAME}\\",\\"password\\":\\"${DOCKERHUB_PASSWORD}\\"}}}" > /kaniko/.docker/config.json
          cat /kaniko/.docker/config.json
          /kaniko/executor -f `pwd`/Dockerfile -c `pwd` --insecure --skip-tls-verify --destination=martinlourduswamy/mag-tools:latest --build-arg=PACKER_VERSION=\$packer_version        
        """
        }
      }
    }
  }
}
