using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.Generar_Publicación
{
    public partial class CrearPublicacion : Form
    {
        String username;
        decimal comisionPublicacion;
        decimal comisionVenta;
        decimal comisionEnvio;

        public CrearPublicacion(String username)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            this.username = username;
            this.inicializarCampos();
        }

        private void inicializarCampos()
        {
            this.llenarComboBoxVisibilidades();
            comboBox1.SelectedIndex = 0;
            comboBox2.SelectedIndex = 0;
            textBox2.Text = Dominio.Fecha.getFechaActual().ToString();
            textBox3.Text = Dominio.Fecha.getFechaActual().AddDays(7).ToString();

            if (Dominio.Usuario.esUsuarioNuevo(this.username).Equals(1))
            {
                label16.Show();
                comisionPublicacion = 0;
                textBox7.Text = "0.00";
            }
            else
                comisionPublicacion = Dominio.Visibilidad.getComisionPublicacion(comboBox2.SelectedItem.ToString());


            comisionVenta = Dominio.Visibilidad.getComisionVenta(comboBox2.SelectedItem.ToString());
            comisionEnvio = Dominio.Visibilidad.getComisionEnvio(comboBox2.SelectedItem.ToString());

            String tipoUsuario = Dominio.Usuario.getTipoUsuario(this.username);

            if (tipoUsuario.Equals("Administrador"))
                button3.Enabled = false;
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            numericUpDown1.Value = 1;
            numericUpDown1.Enabled = false;
            this.llenarCamposComisiones();
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            numericUpDown1.Value = 1;
            numericUpDown1.Enabled = true;
            this.llenarCamposComisiones();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ABM_Rubro.ListadoRubros listadoRubros = new ABM_Rubro.ListadoRubros(this);
            listadoRubros.Show();
        }

        public void setRubro(String nombreRubro)
        {
            textBox1.Text = nombreRubro;
        }

        private void llenarComboBoxEstados()
        {
            comboBox1.Items.Add("Activa");
            comboBox1.Items.Add("Borrador");
        }

        private void llenarComboBoxVisibilidades()
        {
            List<String> visibilidades = Dominio.Visibilidad.getNombresVisibilidades();

            for (int i = 0; i < visibilidades.Count; i++)
            {
                comboBox2.Items.Add(visibilidades[i]);
            }
        }

        private void limpiarCampos()
        {
            radioButton1.Select();
            textBox1.Clear();
            textBox4.Clear();
            textBox5.Clear();
            textBox6.Clear();
            textBox7.Clear();
            numericUpDown1.Value = 1;
            numericUpDown2.Value = 0;
            comboBox1.SelectedIndex = 0;
            comboBox2.SelectedIndex = 0;
            checkBox1.Checked = false;
            checkBox2.Checked = false;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }

        private String getTipo()
        {
            if (radioButton1.Checked)
                return radioButton1.Text;
            else
                return radioButton2.Text;
        }

        private int getBitCheckBox(CheckBox checkBox)
        {
            if (checkBox.Checked)
                return 1;
            else
                return 0;
        }

        private int getBitRadioButton(RadioButton radioButton)
        {
            if (radioButton.Checked)
                return 1;
            else
                return 0;
        }

        private void validarCampos()
        {
            this.validarRubro();
            this.validarDescripcion();
            this.validarPrecio();
        }

        private void validarRubro()
        {
            if (Validacion.estaVacio(textBox1.Text))
                throw new Exception("Debe ingresar un rubro");
        }

        private void validarDescripcion()
        {
            if (Validacion.estaVacio(textBox4.Text))
                throw new Exception("Debe ingresar una descripción");
        }

        private void validarPrecio()
        {
            if (Validacion.esCero(numericUpDown2.Value))
                throw new Exception("Debe ingresar un precio");
        }

        private void crearPublicacion()
        {

            String tipo = this.getTipo();
            String descripcion = textBox4.Text;
            int stock = Convert.ToInt32(numericUpDown1.Value);
            decimal precio = numericUpDown2.Value;
            String rubro = textBox1.Text;
            String estado = comboBox1.SelectedItem.ToString();
            int preguntas = this.getBitCheckBox(checkBox1);
            String visibilidad = comboBox2.SelectedItem.ToString();
            int envio = this.getBitCheckBox(checkBox2);

            SQLManager manager = new SQLManager().generarSP("crearPublicacion")
                                 .agregarStringSP("@usuario", this.username)
                                 .agregarStringSP("@tipo", tipo)
                                 .agregarStringSP("@descripcion", descripcion)
                                 .agregarIntSP("@stock", stock)
                                 .agregarDecimalSP("@precio", precio)
                                 .agregarStringSP("@rubro", rubro)
                                 .agregarStringSP("@estado", estado)
                                 .agregarIntSP("@preguntas", preguntas)
                                 .agregarStringSP("@visibilidad", visibilidad)
                                 .agregarIntSP("@envio", envio);

            manager.ejecutarSP();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                this.validarCampos();
                this.crearPublicacion();
                MessageBox.Show("Publicación creada exitosamente.");
                this.Close();
            }
            catch (Exception excepcion)
            {
                MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
            }

        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            comisionPublicacion = Dominio.Visibilidad.getComisionPublicacion(comboBox2.SelectedItem.ToString());
            comisionVenta = Dominio.Visibilidad.getComisionVenta(comboBox2.SelectedItem.ToString());
            comisionEnvio = Dominio.Visibilidad.getComisionEnvio(comboBox2.SelectedItem.ToString());

            //if (!numericUpDown2.Value.Equals(0)) esto no sé por qué estaba, pero si hay una buena justificación que vuelva
            this.llenarCamposComisiones();

            if (comboBox2.SelectedItem.ToString().Equals("Gratis"))
            {
                checkBox2.Checked = false;
                checkBox2.Hide();
                label12.Visible = false;
                textBox5.Visible = false;
                label9.Visible = false;
            }
            else
                checkBox2.Show();
                label12.Visible = true;
                textBox5.Visible = true;
                label9.Visible = true;
        }

        private void llenarCamposComisiones()
        {
            if (this.getBitRadioButton(radioButton1) == 1)
            {
                textBox6.Text = (comisionVenta * numericUpDown2.Value).ToString("F");
                textBox5.Text = (comisionEnvio * numericUpDown2.Value).ToString("F");

                label10.Text = "AR$";
                label9.Text = "AR$";
            }
            else
            {
                textBox6.Text = (comisionVenta * 100).ToString("F");
                textBox5.Text = (comisionEnvio * 100).ToString("F");

                label10.Text = "%";
                label9.Text = "%";
            }

            decimal.Round(comisionPublicacion, 2, MidpointRounding.AwayFromZero);
            decimal.Round(comisionVenta, 2, MidpointRounding.AwayFromZero);
            decimal.Round(comisionEnvio, 2, MidpointRounding.AwayFromZero);

            if (!Dominio.Usuario.esUsuarioNuevo(this.username).Equals(1))
                textBox7.Text = comisionPublicacion.ToString("F");
        }

        private void CrearPublicacion_Load(object sender, EventArgs e)
        {

        }

        private void numericUpDown2_ValueChanged(object sender, EventArgs e)
        {
           // if (!numericUpDown2.Value.Equals(0))
                this.llenarCamposComisiones();
        }

        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            if (this.getBitCheckBox(checkBox2) == 1)
            {
                label12.Visible = true;
                textBox5.Visible = true;
                label9.Visible = true;
            }
            else
            {
                label12.Visible = false;
                textBox5.Visible = false;
                label9.Visible = false;
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem.ToString() == "Activa")
            {
                textBox2.Text = Dominio.Fecha.getFechaActual().ToString();
                textBox3.Text = Dominio.Fecha.getFechaActual().AddDays(7).ToString();

                textBox2.Show();
                label3.Show();

                textBox3.Show();
                label4.Show();
            }
            else
            {
                textBox2.Hide();
                label3.Hide();

                textBox3.Hide();
                label4.Hide();
            }
        }
    }
}
