package com.project.nadaum.accountbook.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccountBook implements Serializable {

   private static final long serialVersionUID = 1L;

   private String code;
   private String id;
   private String detail;
   private int price;
   private Date reg_date;
   private String income_expensive;
   private String payment;
   private int goal;
}