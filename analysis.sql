-- ============================================
-- Sales Pipeline Analysis
-- Based on HubSpot SLA Methodology
-- ============================================

-- 1. Lead-to-Opportunity Conversion Rate
SELECT 
    COUNT(*) AS total_leads,
	COUNT(CASE WHEN deal_stage!='Prospecting' THEN 1 END) AS opportunities,
	ROUND(COUNT(CASE WHEN deal_stage!='Prospecting' THEN 1 END)*100.0/COUNT(*),2) AS lead_to_op_conv
FROM 
    sales_pipeline;
-- 2. Opportunity-to-Close Conversion Rate
SELECT 
    COUNT(CASE WHEN deal_stage != 'Prospecting' THEN 1 END) AS total_opportunities,
    COUNT(CASE WHEN deal_stage = 'Won' THEN 1 END) AS new_customers,
    ROUND(
        COUNT(CASE WHEN deal_stage = 'Won' THEN 1 END) * 100.0
        / COUNT(CASE WHEN deal_stage != 'Prospecting' THEN 1 END),
    2) AS opp_to_close_conv
FROM sales_pipeline;
-- 3. Deal Size
SELECT 
    ROUND(AVG(close_value),2) AS avg_deal_size
FROM 
    sales_pipeline 
WHERE 
    deal_stage='Won';
-- 4. SLA Calculation
-- Revenue goal: $500,000/month (assumed)
-- Deals needed = revenue_goal / avg_deal_size
-- Opportunities needed = deals_needed / opp_to_close_rate
-- Leads needed = opportunities_needed / lead_to_opp_rate
