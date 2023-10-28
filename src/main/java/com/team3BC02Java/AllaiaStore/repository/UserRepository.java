package com.team3BC02Java.AllaiaStore.repository;

import com.team3BC02Java.AllaiaStore.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    UserEntity findByEmail (String email);
}
