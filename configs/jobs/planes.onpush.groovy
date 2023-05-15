pipelineJob('PlanesOnPush') {    
    displayName('Planes API - On push')
    definition {
        cpsScm {
            scm {
                scriptPath('Jenkinsfile.onpush.groovy')
                git {
                    remote {
                        github('iFairPlay22/Scala-Planes-API')
                    }
                    branches('main')
                    extensions {
                        cleanBeforeCheckout()
                    }
                }
            }
        }
    }
    triggers {
        githubPush()
    }
    
}