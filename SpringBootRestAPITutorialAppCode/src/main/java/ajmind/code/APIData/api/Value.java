// This is our value class -> specify what data from json we need returned(what data is the api offering)
package ajmind.code.APIData.api;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public record Value(Long id, String quote){};

