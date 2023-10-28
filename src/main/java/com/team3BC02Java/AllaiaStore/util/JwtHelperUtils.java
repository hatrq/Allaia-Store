package com.team3BC02Java.AllaiaStore.util;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

@Component
public class JwtHelperUtils {
    @Value("${jwt.token.key}")
    String secrectKey;

    private long expiredTime = 8 * 60 * 60 * 1000;
    public String generateToken(String data){
        Date date = new Date();
        long experiodMilis = date.getTime() + expiredTime;
        Date experitedTime = new Date(experiodMilis);

        SecretKey key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(secrectKey));
        String token = Jwts.builder().setSubject(data).signWith(key).compact();
        return token;
    }


}
