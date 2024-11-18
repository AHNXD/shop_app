import 'package:flutter/material.dart';
import 'package:shop_app/constans.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text(
            'سياسة الخصوصية',
            style: TextStyle(
                fontFamily: Constans.kFontFamily, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'نحن في "بروكر" نلتزم بحماية خصوصية مستخدمينا وضمان أمان بياناتهم الشخصية. توضح هذه السياسة كيفية جمعنا، واستخدامنا، وحمايتنا للمعلومات الشخصية التي تقدمها لنا.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. المعلومات التي نجمعها:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- الاسم: يُستخدم لتخصيص تجربتك داخل التطبيق.\n'
                '- رقم الهاتف: يُستخدم لأغراض التواصل وتقديم الدعم.\n'
                '- الموقع: يُستخدم لتحسين جودة الخدمات المقدمة من خلال معرفة موقعك الجغرافي.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
              SizedBox(height: 16),
              Text(
                '2. كيفية استخدام المعلومات:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- نستخدم المعلومات التي نجمعها لتحسين الخدمات المقدمة عبر التطبيق، مثل تخصيص التجربة للمستخدم وتقديم دعم أفضل.\n'
                '- لا نقوم ببيع أو مشاركة بياناتك الشخصية مع أطراف اخرى إلا إذا كان ذلك ضروريًا لتقديم خدماتنا أو كان مطلوبًا بموجب القانون.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
              SizedBox(height: 16),
              Text(
                '3. حماية البيانات:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- نتخذ كافة التدابير الأمنية اللازمة لحماية بياناتك الشخصية من الوصول غير المصرح به .',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
              SizedBox(height: 16),
              Text(
                '4. تحديثات على سياسة الخصوصية:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. سيتم إشعارك بأي تغييرات من خلال التطبيق أو عبر البريد الإلكتروني.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Constans.kFontFamily, // استخدام الخط المحدد
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
