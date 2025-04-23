package com.example.demo.config;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeUnit;

//import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;


public class ConnectionPoolImlp implements ConnectionPool {
	private String url;
    private String user;
    private String password;
    private LinkedBlockingDeque<Connection> connectionPool;
    private final int INITIAL_POOL_SIZE = 10;
    private static volatile  ConnectionPoolImlp INSTANCE;
    
    
    private ConnectionPoolImlp(String user, String password, String url) throws SQLException  {
    	this.user = user;
    	this.password = password;
    	this.url = url;
    	this.connectionPool = new LinkedBlockingDeque<>(this.INITIAL_POOL_SIZE);
    	this.initializePool();
    }
    private  void initializePool() throws SQLException{
    	for (int i = 0; i < this.INITIAL_POOL_SIZE; i++) {
    		Connection connection = this.createConnection();
    		connection.setAutoCommit(false);
    		this.connectionPool.offerFirst(connection);
    		//System.out.println("Initialized connection pool with 10 connections.");
    	}
    }
    
    private Connection createConnection() throws SQLException{
    	return DriverManager.getConnection(this.url, this.user, this.password);
    }
	@Override
public Connection getConnection() throws SQLException {
		try {
			
			Connection connection = this.connectionPool.pollFirst(3, TimeUnit.SECONDS);
			if (connection == null) {
				throw new SQLException("Pool is empty!");
			}
			if (!connection.isClosed() && connection.isValid(1)) {
				connection.clearWarnings();
				//System.out.println(">> Borrowed a connection");
				return connection;
			} else {
				if (!connection.isClosed()) {
					connection.close();
				}
				connection = this.createConnection();
				connection.setAutoCommit(false);
				return connection;
			}
			
		} catch (InterruptedException e) {
			throw new SQLException("Thread was interrupted while waiting for a connection", e);
		}
	}
	@Override
	public boolean releaseConnection(Connection connection) {
		if (connection != null) {
			this.connectionPool.offerFirst(connection);
			//System.out.println("<< Returned a connection");
			return true;
		}
		
		return false;
	}
	public static synchronized ConnectionPoolImlp getInstance() throws SQLException {
		if (INSTANCE == null) {
			synchronized (ConnectionPoolImlp.class) {
				if(INSTANCE == null) {
					//AnnotationConfigWebApplicationContext   context = new AnnotationConfigWebApplicationContext();
					//context.register(AppConfig.class);
                    //context.setServletContext(new MockServletContext()); // ServletContext giả lập nếu không chạy trên container
                    //context.refresh();
		            try {
		            	//DatabaseConfig config = context.getBean(DatabaseConfig.class);
		    			INSTANCE = new ConnectionPoolImlp(
		    					//config.getUser(),
		    					//config.getPassword(),
		    					//config.getUrl()
		    					"root",
		    					"123456",
		    					"jdbc:mysql://localhost:3306/shopPhone"
		    					);
		            }finally {
		            	//context.close();
		            	//System.out.println("<< Get Instance");

		            }
				}
			}
			
		}
		return INSTANCE;
	}
	@Override
	public void shutdown() {
		for (Connection connection : connectionPool) {
	        try {
	            if (!connection.isClosed()) {
	                connection.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
}
