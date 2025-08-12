# a. Current replica count
.spec.replicas

# b. Deployment strategy  
.spec.strategy.type

# c. Service-Environment concatenation
(.metadata.labels.service + "-" + .metadata.labels.environment)