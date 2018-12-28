using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CamCtrl : MonoBehaviour {

    [SerializeField, Range(0f, 10f)]
    float _speed = 1f;

    [SerializeField, Range(0f, 90f)]
    float _amp = 60f;

    [SerializeField, Range(-90f, 90f)]
    float _offset = 0f;

    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {

        transform.localEulerAngles = new Vector3(0f, Mathf.Sin(Time.time * _speed) * _amp + _offset, 0f);

	}
}
