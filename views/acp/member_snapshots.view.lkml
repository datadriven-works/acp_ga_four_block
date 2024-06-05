view: member_snapshots {
  derived_table: {
    datagroup_trigger: acp_default_datagroup
    sql: SELECT
        log_id,
        ga_client_id,
        IF(JSON_EXTRACT_SCALAR(member_snapshot, '$.authorized') IN ('true', '1'), TRUE, FALSE) AS authorized,
        IF(JSON_EXTRACT_SCALAR(member_snapshot, '$.is_active_user') IN ('true', '1'), TRUE, FALSE) AS is_active_user,
        CAST(JSON_EXTRACT_SCALAR(member_snapshot, '$.code') AS INT64) AS code,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.id') AS user_id,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.token') AS user_token,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.last_first') AS last_first,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.co_id') AS co_id,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.member_type') AS member_type,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.member_type_description') AS member_type_description,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.email') AS email,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.username') AS username,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.number') AS number,  -- Directly as string
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.first_name') AS first_name,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.last_name') AS last_name,
        IF(JSON_EXTRACT_SCALAR(member_snapshot, '$.user.member') IN ('true', '1'), TRUE, FALSE) AS member,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.web_roles') AS web_roles,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.user.wp_member_token_received') AS wp_member_token_received,
        IF(JSON_EXTRACT_SCALAR(member_snapshot, '$.is_user') IN ('true', '1'), TRUE, FALSE) AS is_user,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.service_message') AS service_message,
        JSON_EXTRACT_SCALAR(member_snapshot, '$.member_token_received') AS member_token_received
      FROM
        `alien-grove-412814.mysql_wp_acpmain.wp_cpo_activity` ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: log_id {
    type: number
    sql: ${TABLE}.log_id ;;
  }

  dimension: ga_client_id {
    type: string
    sql: ${TABLE}.ga_client_id ;;
  }

  dimension: authorized {
    type: yesno
    sql: ${TABLE}.authorized ;;
  }

  dimension: is_active_user {
    type: yesno
    sql: ${TABLE}.is_active_user ;;
  }

  dimension: code {
    type: number
    sql: ${TABLE}.code ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_token {
    type: string
    sql: ${TABLE}.user_token ;;
  }

  dimension: last_first {
    type: string
    sql: ${TABLE}.last_first ;;
  }

  dimension: co_id {
    type: string
    sql: ${TABLE}.co_id ;;
  }

  dimension: member_type {
    type: string
    sql: ${TABLE}.member_type ;;
  }

  dimension: member_type_description {
    type: string
    sql: ${TABLE}.member_type_description ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: number {
    type: string
    sql: ${TABLE}.number ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: member {
    type: yesno
    sql: ${TABLE}.member ;;
  }

  dimension: web_roles {
    type: string
    sql: ${TABLE}.web_roles ;;
  }

  dimension: wp_member_token_received {
    type: string
    sql: ${TABLE}.wp_member_token_received ;;
  }

  dimension: is_user {
    type: yesno
    sql: ${TABLE}.is_user ;;
  }

  dimension: service_message {
    type: string
    sql: ${TABLE}.service_message ;;
  }

  dimension: member_token_received {
    type: string
    sql: ${TABLE}.member_token_received ;;
  }

  set: detail {
    fields: [
      log_id,
      authorized,
      is_active_user,
      code,
      user_id,
      user_token,
      last_first,
      co_id,
      member_type,
      member_type_description,
      email,
      username,
      number,
      first_name,
      last_name,
      member,
      web_roles,
      wp_member_token_received,
      is_user,
      service_message,
      member_token_received
    ]
  }
}
