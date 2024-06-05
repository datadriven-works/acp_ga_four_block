view: acp_user {
  derived_table: {
    datagroup_trigger: acp_default_datagroup
    sql: SELECT
        *
      FROM (
        SELECT
          *,
          REGEXP_EXTRACT(ga_client_id, r'^GA\d+\.\d+\.(.*)$') as ga_user_pseudo_id,
          ROW_NUMBER() OVER (PARTITION BY REGEXP_EXTRACT(ga_client_id, r'^GA\d+\.\d+\.(.*)$') ORDER BY log_id DESC) AS rn
        FROM
          ${member_snapshots.SQL_TABLE_NAME}
        WHERE user_id IS NOT NULL
      ) sub
      WHERE rn = 1 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: max_log_id {
    type: number
    sql: ${TABLE}.log_id ;;
  }

  dimension: ga_client_id {
    type: string
    sql: ${TABLE}.ga_client_id ;;
  }

  dimension: ga_user_pseudo_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ga_user_pseudo_id ;;
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

  dimension: rn {
    type: number
    sql: ${TABLE}.rn ;;
  }

  set: detail {
    fields: [
      max_log_id,
      ga_client_id,
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
      member_token_received,
      rn
    ]
  }
}
