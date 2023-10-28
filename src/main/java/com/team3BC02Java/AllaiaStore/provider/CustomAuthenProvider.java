package com.team3BC02Java.AllaiaStore.provider;

import com.team3BC02Java.AllaiaStore.entity.UserEntity;
import com.team3BC02Java.AllaiaStore.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CustomAuthenProvider implements AuthenticationProvider {
    @Autowired
    UserRepository userRepository;

    @Autowired
    @Lazy
    PasswordEncoder passwordEncoder;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String email = authentication.getName();
        String password = authentication.getCredentials().toString();
        UserEntity userEntity = userRepository.findByEmail(email);
        if (userEntity != null){
            if (passwordEncoder.matches(password, userEntity.getPassword())){
                List<GrantedAuthority> role = new ArrayList<>();
                GrantedAuthority grantedAuthority = new SimpleGrantedAuthority("ADMIN");
                role.add(grantedAuthority);
                UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(password, email, role);
                return token;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
