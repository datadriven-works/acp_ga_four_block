view: wp_users {
  view_label: "Admin Users"
  sql_table_name: `alien-grove-412814.mysql_wp_acpmain.wp_users` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._fivetran_deleted ;;
  }
  dimension_group: _fivetran_synced {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}._fivetran_synced ;;
  }
  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }
  dimension: user_activation_key {
    type: string
    sql: ${TABLE}.user_activation_key ;;
  }
  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email ;;
  }
  dimension: user_login {
    type: string
    sql: ${TABLE}.user_login ;;
  }
  dimension: user_nicename {
    type: string
    sql: ${TABLE}.user_nicename ;;
  }
  dimension: user_pass {
    type: string
    sql: ${TABLE}.user_pass ;;
  }
  dimension_group: user_registered {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.user_registered ;;
  }
  dimension: user_status {
    type: number
    sql: ${TABLE}.user_status ;;
  }
  dimension: user_url {
    type: string
    sql: ${TABLE}.user_url ;;
  }
  measure: count {
    type: count
    drill_fields: [id, user_nicename, display_name]
  }
}
