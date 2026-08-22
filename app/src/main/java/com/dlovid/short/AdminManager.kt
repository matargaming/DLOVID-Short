package com.dlovid.short

object AdminManager {
    private const val ADMIN_EMAIL = "matargaming17@gmail.com"
    private val ADMIN_PASSWORDS = listOf(
        "Bosmatar123.321",
        "Bosmatar456.654",
        "BOSMATAR21100169830188"
    )

    fun isAdmin(email: String, password: String): Boolean {
        return email == ADMIN_EMAIL && ADMIN_PASSWORDS.contains(password)
    }

    fun isAdminEmail(email: String): Boolean {
        return email == ADMIN_EMAIL
    }

    fun isAdminPassword(password: String): Boolean {
        return ADMIN_PASSWORDS.contains(password)
    }
}
