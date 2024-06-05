# The name of this view in Looker is "Wp Cpo Activity"
view: wp_cpo_activity {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `mysql_wp_acpmain.wp_cpo_activity` ;;
  drill_fields: [log_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: log_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.log_id ;;
  }
  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called " Fivetran Deleted" in Explore.

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._fivetran_deleted ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: ga_client_id {
    type: string
    sql: ${TABLE}.ga_client_id ;;
  }

  dimension_group: log_date_gmt {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.log_date_gmt ;;
  }

  dimension: member_snapshot {
    # hidden: yes
    type: string
    sql: ${TABLE}.member_snapshot ;;
  }

  dimension: member_token {
    type: string
    sql: ${TABLE}.member_token ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }
  measure: count {
    type: count
    drill_fields: [log_id]
  }
}
