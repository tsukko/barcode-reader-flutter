package jp.co.integrityworks.qr_code

import android.view.MenuItem
import android.view.View
import androidx.appcompat.widget.Toolbar
import io.flutter.embedding.android.FlutterActivity

open class BaseScannerActivity : FlutterActivity() {
    fun setupToolbar() {
        val toolbar = findViewById<View>(R.id.toolbar) as Toolbar
//        setSupportActionBar(toolbar)
//        val ab = supportActionBar
//        ab?.setDisplayHomeAsUpEnabled(true)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            android.R.id.home -> {
                finish()
                return true
            }
        }
        return super.onOptionsItemSelected(item)
    }
}