#!/bin/sh
#
# Note: this script uses the CSV manipulation toolkit from
# https://github.com/koles/csv-tools and assumes the 
# reshuffle tool from that toolkit is available on the system
# PATH
#
# Usage: $0 [<target_dir>]
#
# Files are generated into the current directory if no argument
# is provided.

TARGET_DIR=${1:-"."}

function prepare_orders() {
  reshuffle \
    out_orders.csv \
    cp__orderlineid:label.orderlines.order_line_id \
    a__order_id:label.orderlines.order_id \
    a__orderstatus:label.orderlines.order_status \
    d__date:date \
    r__campaigns:label.campaigns.campaign_id \
    r__customers:label.orderlines.customer_id \
    r__products.label.orderlines.product_id \
    f__orderlines__price:fact.orderlines.price \
    f__orderlines__quantity:fact.orderlines.quantity \
    > "${TARGET_DIR}/order_lines.csv"
}

function prepare_customers() {
  reshuffle \
    out_customers.csv \
    cp__id:label.orderlines.customer_id \
    a__name:label.orderlines.customer_name \
    a__state:label.orderlines.state \
    > "${TARGET_DIR}/customers.csv"
}

function prepare_products() {
  reshuffle \
    out_products.csv \
    cp__product_id:label.orderlines.product_id \
    a__product_name:label.orderlines.product_name \
    a__category:label.orderlines.category \
    > "${TARGET_DIR}/products.csv"
}

function prepare_campaigns() {
  reshuffle \
    out_campaigns.csv \
    cp__campaignid:label.campaigns.campaign_id \
    a__campaign__name:label.campaigns.campaign_name \
    > "${TARGET_DIR}/campaigns.csv"
}

function prepare_campaigns_channels() {
  reshuffle \
    out_campaign_channels.csv \
    cp__channel__campaign_channel_id:campaign_channels.campaign_channel_id \
    a__channel__channel_category:label.campaign_channels.category \
    a__channel__type:label.campaign_channels.type \
    f__channel__budget:fact.campaign_channels.budget \
    f__channel__spend:fact.campaign_channels.spend \
    r__campaigns \
    > "${TARGET_DIR}/campaign_channels.csv"
}


prepare_orders
prepare_customers
prepare_products
prepare_campaigns
prepare_campaigns_channels
