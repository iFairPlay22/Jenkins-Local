pipelineJob('VehiclesOnPush') {    
    displayName('Vehicles API - On push')
    definition {
        cpsScm {
            scm {
                scriptPath('Jenkinsfile.onpush.groovy')
                git {
                    remote {
                        github('iFairPlay22/Scala-Vehicles-API')
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