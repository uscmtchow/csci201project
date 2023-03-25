package com.example.demo;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.InvalidResultSetAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;

@SpringBootApplication
public class UscQuizBackendApplication implements CommandLineRunner{

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LoggerFactory.getLogger(UscQuizBackendApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(UscQuizBackendApplication.class, args);
	}
	@Override
	public void run(String... args) throws Exception {
	
		SimpleJdbcInsert insertActor = new SimpleJdbcInsert(jdbcTemplate);
		insertActor.withTableName("user").usingGeneratedKeyColumns("id");
		User newUser = new User("Evan Loo", "evan2hsie@usc.edu", "password1");
		
		MapSqlParameterSource params = new MapSqlParameterSource();
		 
//		params.addValue("username", user.getUsername())
//		    .addValue("email", user.getEmail())
//		    .addValue("password", user.getPassword());
		try
		{
			// Insert code
			BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(newUser);
			Number newId = insertActor.executeAndReturnKey(paramSource);
			
			if (newId != null) {
			    System.out.println("Insert Successfully. New Id = " + newId.intValue());
			}
			
			
			// Your Code 
		    log.info("Querying for customer records where first_name = 'Evan Loo':");
			jdbcTemplate.query(
			        "SELECT id, username, email, password FROM user WHERE username = ?", new Object[] { "Evan Loo" },
			        (rs, rowNum) -> new User(rs.getString("username"), rs.getString("email"), rs.getString("password"))
			    ).forEach(user -> System.out.println(user.toString()));
			System.out.print(false);
			
		}
		
		catch (InvalidResultSetAccessException e) 
		{
		    throw new RuntimeException(e);
		} 
		catch (DataAccessException e)
		{
		    throw new RuntimeException(e);
		}
		
	}
}
