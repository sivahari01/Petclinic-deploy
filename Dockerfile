# ===============================
# Java JDK (required for jcmd, jstat, jmap)
# ===============================
FROM eclipse-temurin:17-jdk

# ===============================
# Application directory
# ===============================
WORKDIR /app

# ===============================
# Copy build output (keep original jar name)
# ===============================
COPY target/ target/

# ===============================
# Expose Spring Boot port
# ===============================
EXPOSE 8080

# ===============================
# JVM OPTIONS (DEFAULTS)
# You will CHANGE these often for experiments
# ===============================
ENV JAVA_OPTS="\
-Xms256m \
-Xmx256m \
-XX:+UseG1GC \
-XX:MaxGCPauseMillis=200 \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:HeapDumpPath=/tmp \
-XX:+ExitOnOutOfMemoryError \
-Xlog:gc*,gc+heap=info,gc+age=trace"

# ===============================
# Run EXACT command you use locally
# java -jar target/*.jar
# ===============================
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar target/*.jar"]

