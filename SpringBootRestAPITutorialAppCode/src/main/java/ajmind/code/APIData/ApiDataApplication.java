//Includes LOGGER, RestTemplate->for parsing trhe jackson data, and COmmandLine Runer -> for running the rest template
package ajmind.code.APIData;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
//Added packages for logger, Commandlinerunner and RestTemplate
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Profile;
import org.springframework.web.client.RestTemplate;

import ajmind.code.APIData.api.Quote;


@SpringBootApplication
public class ApiDataApplication {

	//added logger here
	private static final Logger log = LoggerFactory.getLogger(ApiDataApplication.class);
	public static void main(String[] args) {
		SpringApplication.run(ApiDataApplication.class, args);
	}

	//Add in beans for spring boot application in order to land the data
	//Bean to build the rest template
	@Bean
	public RestTemplate restTemplate(RestTemplateBuilder builder){
		return builder.build();
	}
	//Add in bean for the command line runner, remember, the command line runner is what we will use to run the rest template after it is created
	@Bean
	@Profile("!test")
	public CommandLineRunner run(RestTemplate restTemplate) throws Exception {
		return args -> {
			Quote quote = restTemplate.getForObject(
					"http://localhost:8089/api/random", Quote.class);
			log.info(quote.toString());
		};
	}
}
