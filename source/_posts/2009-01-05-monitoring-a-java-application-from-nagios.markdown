---
author: pim-van-der-wal
published: true
date: '2009-01-05 16:16:47'
layout: post
slug: monitoring-a-java-application-from-nagios
status: publish
title: Monitoring a Java application from Nagios
wordpress_id: '174'
categories:
- monitoring
- Nagios
tags:
- java
- monitoring
- Nagios
---

This is a slight departure from our regular programming. Instead of just concentrating on the sys admin side of things I want to show how to add a Nagios check to an existing application. In this case we have a Java application for which we want to monitor whether it is running or not. Later on we can make this more detailed by monitoring error codes in the application but for the moment let's keep it simple.

**Configuring Nagios**
On the Nagios end of things we need to define a command to perform a check on a specific port of the server where the application is running. Add a line like this to the objects/commands.cfg file of your Nagios installation.
`
define command{
command_name check_your_application_name
command_line $USER1$/check_tcp -H $HOSTADDRESS$ -p $ARG1$ -e "This application is alive and well"
}`

The -e parameter checks for a specific text that is to be returned by the application. This we can use later on to check for more detailed information. Next we need to add a service to Nagios for using this command. We do this by adding the following lines to the objects/localhost.cfg file. To keep this short I left out some lines which configure the frequency of the checks and the types of alerts.
`
define service {
use                    generic-service
host_name              your_server_name
service_description    your_service_name
check_command          check_your_application_name!2222
}`

**Creating a listener port in Java**
In the second part I will show you the actual code to add to your application. Because this is a blog post I left out the package definition and the includes, but other than that the class itself is usable. To add the check to the Java app we need to add a listener thread to application. We do this by creating a class that is derived from Thread. This listener will open a port which is specified by the main application and a respond to any incoming data with a preset text. We really don't care about the input on this end so any input will be  ignored:

    
    public class NagiosChecker extends Thread {
        // Server socket
        private ServerSocket srv;
    
        // Flag that indicates whether the poller is running or not.
        private boolean isRunning = true;
    
        // Constructor.
        public OVMChecker(ServerSocket srv) {
            this.isRunning = true;
            this.srv = srv;
        }
    
        // Method for terminating the listener
        public void terminate() {
            this.isRunning = false;
        }
    
        /**
        * This method start the thread and performs all the operations.
        */
        public void run() {
            try {
                // Wait for connection from client.
                while (isRunning) {
                    Socket socket = srv.accept();
    
                // Open a reader to receive (and ignore the input)
                BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream()));
    
                // Write the status message to the outputstream
                try {
                    BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
                    wr.write("This application is alive and well");
                    wr.flush();
                } catch (IOException e) {
                    System.out.println(e.getMessage()));
                }
    
                // Close the inputstream since we really don't care about it
                rd.close();
            } catch (Exception e) {
                System.out.println(e.getMessage()));
            }
        }
    }


In case you're still reading this you're probably interested in how to call this class. The following code should be executed in the initialization of the application. It creates the actual socket for port 2222 and starts the listener class. After this the listener class will run indefinitely until the application terminates.

    
    ServerSocket srv = null;
    try {
        srv = new ServerSocket(2222);
        NagiosChecker checker = new NagiosChecker(srv);
        checker.start();
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
