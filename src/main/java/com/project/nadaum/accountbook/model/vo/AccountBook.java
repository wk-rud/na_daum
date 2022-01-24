package com.project.nadaum.accountbook.model.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
   @DateTimeFormat(pattern="yyyy-MM-dd")
   private Date reg_date;
   private String income_expense;
   private String payment;
   private String category;
}