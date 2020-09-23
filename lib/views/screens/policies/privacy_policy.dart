import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatefulWidget {
  final Function onBackPressed;

  const PrivacyPolicy({
    Key key,
    @required this.onBackPressed,
  }) : super(key: key);

  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<PrivacyPolicy> with WidgetsBindingObserver {
  Brightness _brightnessValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    _brightnessValue ??= MediaQuery.of(context).platformBrightness;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "Política de Privacidad",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => widget.onBackPressed.call(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Text(
              """QuickPlanner creó la aplicación QuickPlanner como una aplicación comercial. Este SERVICIO es proporcionado por QuickPlanner y está diseñado para usarse tal cual.\n
Esta página se utiliza para informar a los visitantes sobre nuestras políticas con la recopilación, el uso y la divulgación de información personal si alguien decide utilizar nuestro Servicio.

Si elige utilizar nuestro Servicio, entonces acepta la recopilación y el uso de información en relación con esta política. La información personal que recopilamos se utiliza para proporcionar y mejorar el servicio. No usaremos ni compartiremos su información con nadie excepto como se describe en esta Política de Privacidad.

Los términos utilizados en esta Política de privacidad tienen el mismo significado que en nuestros Términos y condiciones, a los que se puede acceder en QuickPlanner a menos que se defina lo contrario en esta Política de privacidad.""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Recopilación y uso de información",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Para una mejor experiencia, mientras utiliza nuestro Servicio, es posible que le solicitemos que nos proporcione cierta información de identificación personal, que incluye, entre otros, correo electrónico, nombre. La información que solicitamos será retenida por nosotros y utilizada como se describe en esta política de privacidad.\n
La aplicación utiliza servicios de terceros que pueden recopilar información utilizada para identificarlo.

Enlace a la política de privacidad de los proveedores de servicios externos utilizados por la aplicación

Servicios de Google Play
Google Analytics para Firebase""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Registro de datos",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Queremos informarle que cada vez que utiliza nuestro Servicio, en caso de error en la aplicación, recopilamos datos e información (a través de productos de terceros) en su teléfono llamado Datos de registro. Estos Datos de registro pueden incluir información como la dirección de Protocolo de Internet ("IP") de su dispositivo, el nombre del dispositivo, la versión del sistema operativo, la configuración de la aplicación cuando utiliza nuestro Servicio, la hora y fecha de su uso del Servicio y otras estadísticas.""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Cookies",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Las cookies son archivos con una pequeña cantidad de datos que se utilizan comúnmente como identificadores únicos anónimos. Estos se envían a su navegador desde los sitios web que visita y se almacenan en la memoria interna de su dispositivo.\n
Este Servicio no utiliza estas "cookies" explícitamente. Sin embargo, la aplicación puede utilizar códigos de terceros y bibliotecas que utilizan "cookies" para recopilar información y mejorar sus servicios. Tiene la opción de aceptar o rechazar estas cookies y saber cuándo se envía una cookie a su dispositivo. Si decide rechazar nuestras cookies, es posible que no pueda utilizar algunas partes de este Servicio.""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Proveedores de servicio",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Podemos emplear empresas e individuos de terceros debido a las siguientes razones:\n
Para facilitar nuestro Servicio;
Para proporcionar el Servicio en nuestro nombre;
Para realizar servicios relacionados con el servicio; o
Para ayudarnos a analizar cómo se utiliza nuestro Servicio.
Queremos informar a los usuarios de este Servicio que estos terceros tienen acceso a su Información personal. El motivo es realizar las tareas que se les asignen en nuestro nombre. Sin embargo, están obligados a no divulgar ni utilizar la información para ningún otro propósito.""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Seguridad",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Valoramos su confianza al proporcionarnos su información personal, por lo que nos esforzamos por utilizar medios comercialmente aceptables para protegerla. Pero recuerde que ningún método de transmisión a través de Internet o método de almacenamiento electrónico es 100% seguro y confiable, y no podemos garantizar su absoluta seguridad.""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Enlaces a otros sitios",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Este Servicio puede contener enlaces a otros sitios. Si hace clic en el enlace de un tercero, se le dirigirá a ese sitio. Tenga en cuenta que estos sitios externos no son operados por nosotros. Por lo tanto, le recomendamos encarecidamente que revise la Política de privacidad de estos sitios web. No tenemos control ni asumimos ninguna responsabilidad por el contenido, las políticas de privacidad o las prácticas de sitios o servicios de terceros.""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Cambios a esta política de privacidad",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Es posible que actualicemos nuestra Política de privacidad de vez en cuando. Por lo tanto, le recomendamos que revise esta página periódicamente para ver si hay cambios. Le notificaremos de cualquier cambio publicando la nueva Política de privacidad en esta página.\n
Esta política es efectiva a partir del 2020-09-23""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Contáctanos",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              """Si tiene alguna pregunta o sugerencia sobre nuestra Política de privacidad, no dude en contactarnos.\n
Esta página de política de privacidad fue creada en privacypolicytemplate.net y modificada / generada por App Privacy Policy Generator""",
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: _brightnessValue == Brightness.dark
                    ? QPColors.gainsboro
                    : QPColors.san_juan,
              ),
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _brightnessValue = WidgetsBinding.instance.window.platformBrightness;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
