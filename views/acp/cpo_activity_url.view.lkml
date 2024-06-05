view: cpo_activity_url {
  derived_table: {
    datagroup_trigger: acp_default_datagroup
    sql: SELECT
        log_id,
        url,
        REGEXP_EXTRACT(url, r'https?://([^/]+)') AS base_url,

      ARRAY_LENGTH(SPLIT(TRIM(REGEXP_EXTRACT(url, r'https?://[^/]+(/[^?]*)'), '/'), '/')) AS path_depth,

      ARRAY_TO_STRING(SPLIT(TRIM(REGEXP_EXTRACT(url, r'https?://[^/]+(/[^?]*)'), '/'), '/'), ',') AS path_segments,

      SPLIT(TRIM(REGEXP_EXTRACT(url, r'https?://[^/]+(/[^?]*)'), '/'), '/')[SAFE_ORDINAL(1)] AS path_1,
      SPLIT(TRIM(REGEXP_EXTRACT(url, r'https?://[^/]+(/[^?]*)'), '/'), '/')[SAFE_ORDINAL(2)] AS path_2,

      REGEXP_CONTAINS(url, r'\?') AS has_query,

      ARRAY_TO_STRING((CASE WHEN REGEXP_CONTAINS(url, r'\?') THEN SPLIT(REGEXP_EXTRACT(url, r'\?(.*)'), '&') END), ',') AS query_items,

      ARRAY_TO_STRING(ARRAY(
      SELECT SPLIT(kv, '=')[SAFE_ORDINAL(1)]
      FROM UNNEST(SPLIT(REGEXP_EXTRACT(url, r'\?(.*)'), '&')) AS kv
      ), ',') AS query_keys,

      ARRAY_TO_STRING(ARRAY(
      SELECT IFNULL(SPLIT(kv, '=')[SAFE_ORDINAL(2)], '')
      FROM UNNEST(SPLIT(REGEXP_EXTRACT(url, r'\?(.*)'), '&')) AS kv
      ), ',') AS query_values,

      REGEXP_EXTRACT(ARRAY_REVERSE(SPLIT(TRIM(REGEXP_EXTRACT(url, r'https?://[^/]+(/[^?]*)'), '/'), '/'))[OFFSET(0)], r'^([^/.]+)\.') AS resource_file_name,
      REGEXP_EXTRACT(ARRAY_REVERSE(SPLIT(TRIM(REGEXP_EXTRACT(url, r'https?://[^/]+(/[^?]*)'), '/'), '/'))[OFFSET(0)], r'\.([^.]+)$') AS resource_file_extension
      FROM
      `alien-grove-412814.mysql_wp_acpmain.wp_cpo_activity`
      WHERE
      url IS NOT NULL ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: log_id {
    type: number
    sql: ${TABLE}.log_id ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: base_url {
    type: string
    sql: ${TABLE}.base_url ;;
  }

  dimension: path_depth {
    type: number
    sql: ${TABLE}.path_depth ;;
  }

  dimension: path_segments {
    type: string
    sql: ${TABLE}.path_segments ;;
  }

  dimension: path_1 {
    type: string
    sql: ${TABLE}.path_1 ;;
  }

  dimension: path_2 {
    type: string
    sql: ${TABLE}.path_2 ;;
  }

  dimension: has_query {
    type: yesno
    sql: ${TABLE}.has_query ;;
  }

  dimension: query_items {
    type: string
    sql: ${TABLE}.query_items ;;
  }

  dimension: query_keys {
    type: string
    sql: ${TABLE}.query_keys ;;
  }

  dimension: query_values {
    type: string
    sql: ${TABLE}.query_values ;;
  }

  dimension: resource_file_name {
    type: string
    sql: ${TABLE}.resource_file_name ;;
  }

  dimension: resource_file_extension {
    type: string
    sql: ${TABLE}.resource_file_extension ;;
  }

  set: detail {
    fields: [
      log_id,
      url,
      base_url,
      path_depth,
      path_segments,
      path_1,
      path_2,
      has_query,
      query_items,
      query_keys,
      query_values,
      resource_file_name,
      resource_file_extension
    ]
  }
}
