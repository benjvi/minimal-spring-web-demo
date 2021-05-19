package com.benjvi.demo.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DemoController {

    @GetMapping("/")
    public @ResponseBody String helloWorld() {
        return "Hello World";
    }
}
