namespace WindowsFormsApplication1.ABM_Rol
{
    partial class Modificacion
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.labelNuevoNombre = new System.Windows.Forms.Label();
            this.textboxNuevoNombre = new System.Windows.Forms.TextBox();
            this.cListBoxFuncionalidades = new System.Windows.Forms.CheckedListBox();
            this.labelFuncionalidades = new System.Windows.Forms.Label();
            this.labelNombreActual = new System.Windows.Forms.Label();
            this.textboxNombreActual = new System.Windows.Forms.TextBox();
            this.checkboxHabilitar = new System.Windows.Forms.CheckBox();
            this.buttonGuardar = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // labelNuevoNombre
            // 
            this.labelNuevoNombre.AutoSize = true;
            this.labelNuevoNombre.Location = new System.Drawing.Point(56, 67);
            this.labelNuevoNombre.Name = "labelNuevoNombre";
            this.labelNuevoNombre.Size = new System.Drawing.Size(77, 13);
            this.labelNuevoNombre.TabIndex = 0;
            this.labelNuevoNombre.Text = "Nuevo nombre";
            // 
            // textboxNuevoNombre
            // 
            this.textboxNuevoNombre.Location = new System.Drawing.Point(170, 67);
            this.textboxNuevoNombre.Name = "textboxNuevoNombre";
            this.textboxNuevoNombre.Size = new System.Drawing.Size(100, 20);
            this.textboxNuevoNombre.TabIndex = 1;
            // 
            // cListBoxFuncionalidades
            // 
            this.cListBoxFuncionalidades.FormattingEnabled = true;
            this.cListBoxFuncionalidades.Location = new System.Drawing.Point(170, 111);
            this.cListBoxFuncionalidades.Name = "cListBoxFuncionalidades";
            this.cListBoxFuncionalidades.Size = new System.Drawing.Size(120, 94);
            this.cListBoxFuncionalidades.TabIndex = 2;
            // 
            // labelFuncionalidades
            // 
            this.labelFuncionalidades.AutoSize = true;
            this.labelFuncionalidades.Location = new System.Drawing.Point(56, 111);
            this.labelFuncionalidades.Name = "labelFuncionalidades";
            this.labelFuncionalidades.Size = new System.Drawing.Size(84, 13);
            this.labelFuncionalidades.TabIndex = 3;
            this.labelFuncionalidades.Text = "Funcionalidades";
            // 
            // labelNombreActual
            // 
            this.labelNombreActual.AutoSize = true;
            this.labelNombreActual.Location = new System.Drawing.Point(56, 25);
            this.labelNombreActual.Name = "labelNombreActual";
            this.labelNombreActual.Size = new System.Drawing.Size(76, 13);
            this.labelNombreActual.TabIndex = 4;
            this.labelNombreActual.Text = "Nombre actual";
            // 
            // textboxNombreActual
            // 
            this.textboxNombreActual.Location = new System.Drawing.Point(170, 25);
            this.textboxNombreActual.Name = "textboxNombreActual";
            this.textboxNombreActual.Size = new System.Drawing.Size(100, 20);
            this.textboxNombreActual.TabIndex = 5;
            // 
            // checkboxHabilitar
            // 
            this.checkboxHabilitar.AutoSize = true;
            this.checkboxHabilitar.Location = new System.Drawing.Point(59, 226);
            this.checkboxHabilitar.Name = "checkboxHabilitar";
            this.checkboxHabilitar.Size = new System.Drawing.Size(104, 17);
            this.checkboxHabilitar.TabIndex = 6;
            this.checkboxHabilitar.Text = "Volver a habilitar";
            this.checkboxHabilitar.UseVisualStyleBackColor = true;
            // 
            // buttonGuardar
            // 
            this.buttonGuardar.Location = new System.Drawing.Point(267, 263);
            this.buttonGuardar.Name = "buttonGuardar";
            this.buttonGuardar.Size = new System.Drawing.Size(75, 23);
            this.buttonGuardar.TabIndex = 7;
            this.buttonGuardar.Text = "Guardar";
            this.buttonGuardar.UseVisualStyleBackColor = true;
            // 
            // Modificacion
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(354, 298);
            this.Controls.Add(this.buttonGuardar);
            this.Controls.Add(this.checkboxHabilitar);
            this.Controls.Add(this.textboxNombreActual);
            this.Controls.Add(this.labelNombreActual);
            this.Controls.Add(this.labelFuncionalidades);
            this.Controls.Add(this.cListBoxFuncionalidades);
            this.Controls.Add(this.textboxNuevoNombre);
            this.Controls.Add(this.labelNuevoNombre);
            this.Name = "Modificacion";
            this.Text = "Modificar rol";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelNuevoNombre;
        private System.Windows.Forms.TextBox textboxNuevoNombre;
        private System.Windows.Forms.CheckedListBox cListBoxFuncionalidades;
        private System.Windows.Forms.Label labelFuncionalidades;
        private System.Windows.Forms.Label labelNombreActual;
        private System.Windows.Forms.TextBox textboxNombreActual;
        private System.Windows.Forms.CheckBox checkboxHabilitar;
        private System.Windows.Forms.Button buttonGuardar;
    }
}