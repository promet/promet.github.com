---
author: pim-van-der-wal
date: '2008-06-20 08:24:56'
layout: post
slug: implementing-aes-encryption-in-the-front-end
status: publish
title: Implementing AES encryption in the front-end
wordpress_id: '10'
categories:
- Installation
tags:
- aes
- encryption
- gnu-crypto
- java
- php
- rijndael
---

This post describes a way to implement data encryption in the front-end of an application and how to make it compatible between a PHP front-end and a Java front-end.

First off we need to decide what type of encryption to use. [AES](http://en.wikipedia.org/wiki/Advanced_Encryption_Standard) is an encryption standard that has been endorsed by the NSA and is generally available for most programming languages. It is actually the same as the [Rijndael](http://en.wikipedia.org/wiki/Rijndael) encryption scheme but with a couple of limitations. Rijndael describes a two-way encryption scheme which allows us to encrypt and decrypt data using an encryption key and a random generator. The random generator is used to make sure that when we're encrypting two identical values the resulting encrypted values will be different. Since we're encrypting credit card data like the expiration date this is actually a very desirable feature. The random value is called the [Initialization Vector](http://en.wikipedia.org/wiki/Initialization_vector) (I.V.) and will be stored with the encrypted data. To successfully encrypt and decrypt data we will need information stored in 3 different locations:



	
  1. The encryption key which is stored on the web server in a plain text file

	
  2. The encryption key hash function which is stored in the front-end code

	
  3. The encrypted data and the I.V. which are both stored in the database


Both the encryption key and the hash function are needed to encrypt data. To decrypt data the I.V. and the encrypted data are also needed of course. If any of these items is not available decryption can not take place. The hash function for the encryption key is used to make sure that the key cannot be compromised by just retrieving the key file. The key in the key file needs to be encrypted with an [MD5](http://en.wikipedia.org/wiki/Md5) based function to be useful.

For the second part I will describe how to encrypt and decrypt data using this method in PHP. The main concern here is to use only functions and parameters that are compatible with the Java front-end. As it turns out some PHP functions are not quite as generic as they appear at first glance. The [crypt()](http://us.php.net/manual/en/function.crypt.php) function is a good example of this. Although the crypt() function has MD5 functionality it is by no means generic. The value is encrypted several times and a random value (a salt) is inserted in several locations. With these variations being buried in the PHP source code it is hard to match the same encryption in Java. On the other hand the [md5()](http://us.php.net/manual/en/function.md5.php) function does provide a straightforward implementation of MD5 encryption. It is advisable to apply MD5 several times and insert a hard coded value into the string. This is similar to what the crypt() function does but by doing it ourselves we can make sure of compatibility between the platforms as well as add some security by making it custom.

After encryption the key is ready for use and it is time to encrypt or decrypt the data. PHP comes with the [mcrypt](http://us.php.net/mcrypt) library that supports Rijndael encryption with I.V's (installation of the mcrypt library is described in a previous post). The limitation of using the mcrypt library is that the length of the encryption key and the length of the I.V. must be identical. Furthermore there is no way to specify what method of padding to use. When data is encrypted it will always result in blocks of data of the same size. If the data does not fill up the block completely it is padded with empty data. The default padding method is [TBC](http://www.gnu.org/software/gnu-crypto/manual/api/gnu/crypto/pad/TBC.html). The final code for encrypting a string will look something like this:

    
    <code>$iv = mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256,
              MCRYPT_MODE_CBC), MCRYPT_RAND);
    $encrypted_string = mcrypt_encrypt(MCRYPT_RIJNDAEL_256,
              $key, $input_string, MCRYPT_MODE_CBC, $iv);</code>


The final part of this post will deal with how to implement the same encryption in Java. The first problem we run into is trying to implement this with the standard Java encryption extensions.

First of all the 256 bits version of Rijndael is not supported without the Unlimited Strength Jurisdiction Policy files. These can be downloaded from the main [JDK download page](http://java.sun.com/javase/downloads/index.jsp) at the Sun web site. But even with these files installed we still have some problems like no support for initialization vectors. This means we have to turn to alternative libraries like the [gnu-crypto library](http://www.gnu.org/software/gnu-crypto). This library contains everything we need for compatibility. It allows for the use of initialization vectors, TBC padding and different cypher block modes. We have not touched upon the use of [cypher block modes](http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation) but they define how blocks of data are encrypted. Which mode to use is largely dependent on the type of data will be encrypted and it's definitely outside the scope of this post to delve into that. Originally we started using ECB mode with the PHP front-end but found that that mode is incompatible with the gnu-crypto implementation in Java. Instead we now use the CBC mode.

The Java code is limited to the use of the encryption function but will need to use the IPad class afterwards to add the correct padding.

    
    <code>IMode mode = ModeFactory.getInstance("CBC", "Rijndael", 32);
    Map attributes = new HashMap();
    attributes.put(IMode.KEY_MATERIAL, key);
    attributes.put(IMode.CIPHER_BLOCK_SIZE, new Integer(32));
    attributes.put(IMode.STATE, new Integer(IMode.ENCRYPTION));
    attributes.put(IMode.IV, iv);
    mode.init(attributes);</code>


Some final tips:



	
  * Insert a special string with each encrypted string to make it possible to determine whether a string has been encrypted or not.

	
  * Calculate how big the data will be based on the block sizes and adjust the database columns accordingly. Using 256 bits encryption is very secure but it results in a large block size which is very inefficient for short data.

	
  * If you're upgrading your application to use encryption provide the developers with some easy functions to insert and upgrade the encrypted data.


