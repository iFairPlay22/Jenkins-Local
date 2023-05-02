pipelineJob('VehiclesOnPush') {    
    displayName('Vehicles API - On push')
    definition {
        cpsScm {
            scm {
                github('iFairPlay22/Scala-Vehicles-API', 'main')
                scriptPath('Jenkinsfile.onpush.groovy')
            }
        }
    }
    triggers {
        githubPush()
    }
}