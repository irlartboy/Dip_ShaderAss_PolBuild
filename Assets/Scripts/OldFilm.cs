using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class OldFilm : MonoBehaviour
{
    #region Varibles
    public Shader curShader;

    public float oldFilmAmount = 1.0f;

    public Color sepiaColor = Color.white;
    public Texture2D vignetteTexture;
    public float vignetteAmount = 1.0f;

    public Texture2D scrarchesTexture;
    public float scratchesYSpeed = 10.0f;
    public float scratchesXSpeed = 10.0f;
    
    public Texture2D dustTexture;
    public float dustYSpeed = 10.0f;
    public float dustXSpeed = 10.0f;

    private Material screenMat;
    private float randomValue;
    #endregion
    Material ScreenMat
    {
        get
        {
            if (screenMat == null)
            {
                screenMat = new Material(curShader);
                screenMat.hideFlags = HideFlags.HideAndDontSave;
            }
            return screenMat;
        }    
    }
    void Start()
    {
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }

        if (!curShader && !curShader.isSupported)
        {
            enabled = false;
        }
    }
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (curShader != null)
        {
            ScreenMat.SetColor("_SepiaColor", sepiaColor);
            ScreenMat.SetFloat("_VignetteAmount", vignetteAmount);
            ScreenMat.SetFloat("_EffectAmount", oldFilmAmount);
            if (vignetteTexture)
            {
                ScreenMat.SetTexture("_VignetteTex", vignetteTexture); 
            }
            if (scrarchesTexture)
            {
                ScreenMat.SetTexture("_Scratches", scrarchesTexture);
                ScreenMat.SetFloat("_ScratchesYSpeed", scratchesYSpeed);
                ScreenMat.SetFloat("_ScratchesXSpeed", scratchesXSpeed);
            }
            if (dustTexture)
            {
                ScreenMat.SetTexture("_DustTex", dustTexture);
                ScreenMat.SetFloat("_dustYSpeed", dustYSpeed);
                ScreenMat.SetFloat("_dustXSpeed", dustXSpeed);
                ScreenMat.SetFloat("_RandomValue", randomValue);
            }
            Graphics.Blit(source, destination, ScreenMat);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
    void Update()
    {
        vignetteAmount = Mathf.Clamp01(vignetteAmount);
        oldFilmAmount = Mathf.Clamp(oldFilmAmount, 0f, 1.5f);
        randomValue = Random.Range(-1f, 1f);
    }
    private void OnDisable()
    {
        if (screenMat)
        {
            DestroyImmediate(screenMat);
        }
    }
}
