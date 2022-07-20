package com.example.fitness_ui_kit

data class WaterSettings(
        val currentMilliliters: Int,
        val recommendedMilliliters: Int,
        val alarmEnabled: Boolean
) {
    fun asMap(): Map<String, Any> {
        return mapOf(
                "currentMilliliters" to currentMilliliters,
                "recommendedMilliliters" to recommendedMilliliters,
                "alarmEnabled" to alarmEnabled
        )
    }
}