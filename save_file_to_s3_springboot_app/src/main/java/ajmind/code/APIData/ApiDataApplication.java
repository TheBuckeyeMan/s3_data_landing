package ajmind.code.APIData;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.core.sync.RequestBody;
import ajmind.code.APIData.api.Todo;

@SpringBootApplication
public class ApiDataApplication {

    private static final Logger log = LoggerFactory.getLogger(ApiDataApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(ApiDataApplication.class, args);
    }

    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder) {
        return builder.build();
    }

    @Bean
    public CommandLineRunner run(RestTemplate restTemplate, S3Client s3Client) throws Exception {
        return args -> {
            Todo todo = restTemplate.getForObject(
                    "https://jsonplaceholder.typicode.com/todos/1", Todo.class);

            if (todo != null) {
                String bucketName = "football-data-s3-adam-maas-12202";
                String fileName = "todo.json";
                String fileContent = todo.toString();

                log.info("Attempting to upload to S3 bucket: " + bucketName);
                uploadToS3(s3Client, bucketName, fileName, fileContent);
            } else {
                log.error("Received null Todo object from API");
            }
        };
    }

    private void uploadToS3(S3Client s3Client, String bucketName, String fileName, String fileContent) {
        try {
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(fileName)
                .build();

            s3Client.putObject(putObjectRequest, RequestBody.fromString(fileContent));
            log.info("File uploaded to S3 bucket: " + bucketName + "/" + fileName);
        } catch (Exception e) {
            log.error("Error uploading file to S3", e);
        }
    }
}
