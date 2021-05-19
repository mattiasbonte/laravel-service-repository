<?php

namespace App\Services;

use App\Repositories\MODEL_Upper_singular\REPO_Upper_singularInterface;

class SERVICE_Upper_singularService
{
    /**
     * @var REPO_Upper_singularInterface
     */
    protected REPO_Upper_singularInterface $REPO_lower_singularInterface;

    /**
     * @param REPO_Upper_singularInterface $REPO_lower_singularInterface
     */
    public function __construct(REPO_Upper_singularInterface $REPO_lower_singularInterface)
    {
        $this->REPO_lower_singularInterface = $REPO_lower_singularInterface;
    }

    /**
     * PLACEHOLDER
     */
    public function FUNC_lower_singular(): PLACEHOLDER
    {
        return $this->REPO_lower_singularInterface->FUNC_lower_singular();
    }
}
