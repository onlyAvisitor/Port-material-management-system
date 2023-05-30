package com.yfk.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 解决跨域问题  依靠后端解决后，前端可不做处理
 */
@Configuration
public class CorsConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        //版本较高   使用allowedOriginPatterns替换allowedOrigin

        registry.addMapping("/**")
                .allowedOriginPatterns("*")
                .allowedMethods("GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS", "PATCH")
                .allowCredentials(true)
                .maxAge(3600)
                .allowedHeaders("*");
    }
}
