FROM gcr.io/spark/spark:v3.1.1

USER root
# AWS dependency
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.11.1034/aws-java-sdk-1.11.1034.jar $SPARK_HOME/jars
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar $SPARK_HOME/jars

RUN chmod +r $SPARK_HOME/jars/*

USER 185