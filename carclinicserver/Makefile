dev = clean package deploy-local

develop: $(dev)

clean:
	mvn clean

package:
	mvn package -DskipTests

deploy-local:
	docker build -t car-clinic-server .
	docker run -p "7000:5000" -t car-clinic-server



