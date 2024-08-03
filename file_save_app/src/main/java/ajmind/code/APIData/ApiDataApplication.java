package ajmind.code.APIData;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Profile;
import org.springframework.web.client.RestTemplate;

import ajmind.code.APIData.api.Todo;

//additional java packages located here to WRITE the json response to a file
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

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
    @Profile("!test")
    public CommandLineRunner run(RestTemplate restTemplate) throws Exception {
        return args -> {
            Todo todo = restTemplate.getForObject(
                    "https://jsonplaceholder.typicode.com/todos/1", Todo.class);
			//Log the response we get
			log.info(todo.toString());
			//Add in desktop save location
            saveToFile(todo, "/Users/adammaas/desktop/todo.json");
        };
    }
//add in addditional code to write the response provided in todo and then save to desktop
    private void saveToFile(Todo todo, String filePath) {
        try (FileWriter fileWriter = new FileWriter(new File(filePath))) {
            fileWriter.write(todo.toString());
            log.info("File saved to: " + filePath);
        } catch (IOException e) {
            log.error("Error writing to file", e);
        }
    }
}
