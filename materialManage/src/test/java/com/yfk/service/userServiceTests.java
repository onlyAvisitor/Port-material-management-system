package com.yfk.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class userServiceTests {

    @Autowired
    private UserService userService;

    @Test
    void testgetById() {
        System.out.print(userService.getById(1));
    }

}
